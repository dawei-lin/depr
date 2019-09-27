package com.infinova.depr.config;

import com.infinova.depr.filter.TokenFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author ldw
 * @date 2019/8/20 15:15
 */
/*@Configuration
public class FilterConfig {
    @Bean
    public FilterRegistrationBean registrationBean() {
        FilterRegistrationBean frs = new FilterRegistrationBean();
        frs.setFilter(new TokenFilter());
        frs.addUrlPatterns("/*");
        frs.setOrder(1);
        return frs;
    }
}*/
