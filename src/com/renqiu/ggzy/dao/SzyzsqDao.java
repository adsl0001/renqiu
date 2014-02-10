package com.renqiu.ggzy.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Component;

import com.renqiu.ggzy.entity.Szyzsq;

/**
 * 请假实体管理接口
 * 
 * @author HenryYan
 */
@Component
public interface SzyzsqDao extends CrudRepository<Szyzsq, Long> {
 	@Query("select a from Szyzsq a where a.frsfzh = ?1")
	public List<Szyzsq> findByFrsfzh(String frsfzh);
}
