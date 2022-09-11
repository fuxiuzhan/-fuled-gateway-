package com.fxz.fuled.gateway.fuledgateway;

import com.fxz.fuled.service.annotation.EnableFuledBoot;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;

@EnableFuledBoot
@EnableZuulProxy
public class FuledGatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(FuledGatewayApplication.class, args);
    }

}
