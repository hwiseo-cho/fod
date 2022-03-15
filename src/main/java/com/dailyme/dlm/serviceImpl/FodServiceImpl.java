package com.dailyme.dlm.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dailyme.dlm.dao.FodDao;
import com.dailyme.dlm.service.FodService;

@Service
public class FodServiceImpl implements FodService {

	@Autowired
	private FodDao fodDao;
	
	@Override
	public List<Map<String, Object>> selectMarkerList() {
		return fodDao.selectMarkerList();
	}

}
