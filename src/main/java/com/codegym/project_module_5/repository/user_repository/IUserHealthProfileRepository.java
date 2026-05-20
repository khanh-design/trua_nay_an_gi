package com.codegym.project_module_5.repository.user_repository;

import com.codegym.project_module_5.model.user_model.UserHealthProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IUserHealthProfileRepository extends JpaRepository<UserHealthProfile, Long> {

    Optional<UserHealthProfile> findTopByUserIdOrderByUpdatedAtDesc(Long userId);
}
