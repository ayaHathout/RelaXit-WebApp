package com.relaxit.repository.interfaces;

import com.relaxit.domain.models.*;

public interface UserRepository {

    User findById(Long id);
}
