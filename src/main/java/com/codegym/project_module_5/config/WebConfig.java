package com.codegym.project_module_5.config;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.lang.NonNull;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${upload.avatar.dir:uploads/avatars}")
    private String avatarUploadDir;

    @Override
    public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
        // Build absolute path so it works regardless of working directory
        String absoluteAvatarPath = Paths.get(avatarUploadDir).toAbsolutePath().toString();
        if (!absoluteAvatarPath.endsWith("/") && !absoluteAvatarPath.endsWith("\\")) {
            absoluteAvatarPath += "/";
        }
        registry.addResourceHandler("/avatars/**")
                .addResourceLocations("file:" + absoluteAvatarPath);

        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/");
    }
}
