package com.cart.config;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration //表示是配置类，提供配置，只要当前组件注册到容器中，该类提供的配置就会生效
@PropertySource(value = "classpath:dataSource.properties") //<context:property-placeholder location>
@ComponentScan(value = {"com.cart.service.impl"}) //<context:component-scan base-package>
@MapperScan(value = "com.cart.dao") //<mybatis:scan>
@EnableTransactionManagement //<tx:annotation-driven/>
@EnableAspectJAutoProxy //<aop:aspectj-autoproxy>
public class SpringConfig {
    @Value("${db.driverClassName}") //简单类型的值的装配
    private String driverClassName;//这是注释
    @Value("${db.url}")
    private String url;
    @Value("${db.username}")
    private String username;
    @Value("${db.password}")
    private String password;

    @Value("${db.initialSize}")
    private Integer initialSize;
    @Value("${db.maxActive}")
    private Integer maxActive;

    @Bean(value = "dataSource") //<bean>
    public DataSource dataSource(){
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setDriverClassName(driverClassName);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setInitialSize(initialSize);
        dataSource.setMaxActive(maxActive);
        return dataSource;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {

        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(dataSource);

        Resource configResource = new ClassPathResource("mybatis-config.xml");
        factoryBean.setConfigLocation(configResource);

        Resource mapperResource1 = new ClassPathResource("mapper/UserMapper.xml");
        Resource mapperResource2 = new ClassPathResource("mapper/ProductMapper.xml");
        Resource mapperResource3 = new ClassPathResource("mapper/ProductTypeMapper.xml");
        factoryBean.setMapperLocations(new Resource[]{mapperResource1, mapperResource2, mapperResource3});

        factoryBean.setTypeAliasesPackage("com.cart.entity");

        return factoryBean.getObject();
    }

    @Bean
    public DataSourceTransactionManager transactionManager(DataSource dataSource){
        DataSourceTransactionManager transactionManager = new DataSourceTransactionManager();
        transactionManager.setDataSource(dataSource);
        return transactionManager;
    }
}
