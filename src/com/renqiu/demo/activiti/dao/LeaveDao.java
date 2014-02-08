package com.renqiu.demo.activiti.dao;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Component;

import com.renqiu.demo.activiti.entity.oa.Leave;

/**
 * 请假实体管理接口
 *
 * @author HenryYan
 */
@Component
public interface LeaveDao extends CrudRepository<Leave, String> {
}
