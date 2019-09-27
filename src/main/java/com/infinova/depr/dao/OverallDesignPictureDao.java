package com.infinova.depr.dao;

import com.infinova.depr.entity.OverallDesignPicture;
import com.infinova.depr.entity.OverallDesignRule;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/3 10:50
 */
@Mapper
public interface OverallDesignPictureDao {
    int saveOverallDesignPictureList(List<OverallDesignPicture> overallDesignPictureList);
}
