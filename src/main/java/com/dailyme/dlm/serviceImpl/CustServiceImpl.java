package com.dailyme.dlm.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dailyme.dlm.dao.CustDao;
import com.dailyme.dlm.dao.FodDao;
import com.dailyme.dlm.service.CustService;
import com.dailyme.dlm.service.FodService;

@Service
public class CustServiceImpl implements CustService {

	@Autowired
	private CustDao custDao;
	
	@Override
	public List<Map<String, Object>> selectMarkerList() {
		return custDao.selectMarkerList();
	}

}
