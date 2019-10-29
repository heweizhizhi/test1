package com.cart.config;

import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.*;

import java.util.List;

@Configuration
@ComponentScan(value = "com.cart.controller")
@EnableWebMvc //<mvc:annotation-driven>
public class SpringMvcConfig extends WebMvcConfigurerAdapter {
    //HttpMessage转换器
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        converters.add(new FastJsonHttpMessageConverter());
    }

    //视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/views/", ".jsp");
    }

    //拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    }

    //视图访问控制
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/private/cart/showCart").setViewName("cart");
    }

    //静态资源访问处理
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/");

        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");

        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/");


    }
}
