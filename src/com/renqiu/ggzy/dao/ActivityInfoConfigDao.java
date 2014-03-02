package com.renqiu.ggzy.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Component;

import com.renqiu.ggzy.entity.Szyzsq;

/**
 *  
 * @author  
 */
@Component
public interface ActivityInfoConfigDao extends CrudRepository<Szyzsq, Long> {
}
