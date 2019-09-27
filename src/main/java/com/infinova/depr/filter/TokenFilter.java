package com.infinova.depr.filter;

import com.infinova.depr.utils.JwtTokenUtil;
import io.jsonwebtoken.Claims;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author ldw
 * @date 2019/8/20 14:46
 */
public class TokenFilter extends OncePerRequestFilter {
    static Logger logger = LoggerFactory.getLogger(TokenFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        logger.info("开始校验用户信息");
        String token = null;
        Claims claims = null;
        token = request.getHeader("token");
        if (StringUtils.isNotEmpty(token) && !JwtTokenUtil.isTokenExpired(token)) {
            claims = JwtTokenUtil.getClaimsFromToken(token);
            if (claims != null && StringUtils.isNotEmpty(MapUtils.getString(claims, "USER_NAME"))) {
                request.setAttribute("userName", MapUtils.getString(claims, "USER_NAME"));
                request.setAttribute("deptName", MapUtils.getString(claims, "USER_DEPARTMENT"));
                logger.info("该用户已登录，放行");
                chain.doFilter(request, response);
            } else {
                logger.info("校验失败");
                response.setStatus(401);
            }
        } else if (StringUtils.isNotEmpty(request.getParameter("token")) && !JwtTokenUtil.isTokenExpired(request.getParameter("token"))) {
            token = request.getParameter("token");
            claims = JwtTokenUtil.getClaimsFromToken(token);
            if (claims != null && StringUtils.isNotEmpty(MapUtils.getString(claims, "USER_NAME"))) {
                request.setAttribute("userName", MapUtils.getString(claims, "USER_NAME"));
                request.setAttribute("deptName", MapUtils.getString(claims, "USER_DEPARTMENT"));
                logger.info("该用户已登录，放行");
                chain.doFilter(request, response);
            } else {
                logger.info("校验失败");
                response.setStatus(401);
            }
        } else {
            logger.info("校验失败");
            response.setStatus(401);
        }
    }
}
