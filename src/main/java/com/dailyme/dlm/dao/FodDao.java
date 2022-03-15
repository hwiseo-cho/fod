package com.dailyme.dlm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FodDao {

	List<Map<String,Object>> selectMarkerList();
	
}
