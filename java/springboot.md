

### 过滤器

**它是Servlet的，是不归springmvc管的，所以全局异常处理器，是管不到它**

它是栈结构，后进先出

有过滤器链（设计模式）



#### 使用步骤

1.**实现Filter的doFilter方法**

```java
import javax.servlet.*;
import java.io.IOException;

public class MyFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 初始化操作
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // 处理请求前的操作
        System.out.println("Filter is invoked before");
        chain.doFilter(request, response); // 继续请求 用了，doFilter 才是放行
        // 处理请求后的操作
        System.out.println("Filter is invoked after");
    }

    @Override
    public void destroy() {
        // 销毁操作
    }
}

```



2.**将过滤器注册为 Spring Bean** 通过 `@Bean` 将过滤器注册到 Spring 容器中。

```java
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MyFilter> filterRegistrationBean() {
        FilterRegistrationBean<MyFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new MyFilter());
        registrationBean.addUrlPatterns("/api/*");  // 过滤器应用的路径
        return registrationBean;
    }
}

```



也可以不用@Configuration 但是不好，不太灵活

```java
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

// 用的是WebFilter 但是要在启动类加上扫描它的注解
@WebFilter(urlPatterns = "/api/*")
public class MyFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getServletPath();
        
        // 排除某些路径
        if ("/api/login".equals(path) || "/api/register".equals(path)) {
            chain.doFilter(request, response); // 直接放行
        } else {
            // 正常的过滤器逻辑
            System.out.println("Filter is invoked");
            chain.doFilter(request, response);
        }
    }

    // 其他方法省略...
}

```

![image-20240925153201253](../../../AppData/Roaming/Typora/typora-user-images/image-20240925153201253.png)

就是 @WebFilter + @SeravletComponentScan

#### 弊端

我感觉他有一个弊端，就是排除过滤路径，自定义编码

```java
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<MyFilter> filterRegistrationBean() {
        FilterRegistrationBean<MyFilter> registrationBean = new FilterRegistrationBean<>(new MyFilter());
        
        // 拦截的路径
        registrationBean.addUrlPatterns("/api/*");
        
        // 排除的路径，可以使用自定义逻辑排除路径
        registrationBean.setUrlPatterns(null); // 清空默认的路径匹配
        registrationBean.setFilter(new MyFilter());
        registrationBean.addUrlPatterns("/api/*");  // 设置要拦截的路径

        // 设置排除的路径逻辑 (自定义实现)
        registrationBean.setFilter(new MyFilter() {
            @Override
            public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
                    throws IOException, ServletException {
                HttpServletRequest req = (HttpServletRequest) request;
                String path = req.getServletPath();
                if ("/api/login".equals(path) || "/api/register".equals(path)) {
                    chain.doFilter(request, response); // 直接放行 有点low
                } else {
                    super.doFilter(request, response, chain); // 执行过滤器逻辑
                }
            }
        });

        return registrationBean;
    }
}

```



#### 作用

对传进的参数进行检查，or 可以检查是否登入，如果登入，就将用户信息存入ThreadLocal

### 拦截器



**它是springmvc的，应该可以被全局异常拦截器，管到**



#### 使用

1.还是继承 or 实现，好吧 是实现，也是 用@Configuration + @Bean

```java
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyInterceptor implements HandlerInterceptor {

    // 处理请求之前的操作
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("Interceptor: preHandle");
        return true; // 返回 false 则请求不会继续执行
    }

    // 处理请求之后的操作
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           org.springframework.web.servlet.ModelAndView modelAndView) throws Exception {
        System.out.println("Interceptor: postHandle");
    }

    // 视图渲染之后的操作
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("Interceptor: afterCompletion");
    }
}

```

2.用@Configuration + @Bean

```java
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new MyInterceptor()).addPathPatterns("/api/**"); // 拦截指定路径
    }
}

```

但是它是可以用@Configuration，配置排除路径的

![image-20240925153012234](../../../AppData/Roaming/Typora/typora-user-images/image-20240925153012234.png)



#### 作用

对传进的参数进行检查，or 可以检查是否登入，如果登入，就将用户信息存入ThreadLocal

比如 token，JWT，也可以用redis  存用户和token进行检查