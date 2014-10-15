package com.renqiu.ggzy.dao;

import org.springframework.data.repository.CrudRepository;

import com.renqiu.ggzy.entity.TestModel;

public interface TestModelDao extends  CrudRepository<TestModel, Long> { 

}
