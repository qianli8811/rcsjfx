package com.jeeplus.modules.xssj.schedule;

import com.jeeplus.common.utils.CacheUtils;
import com.jeeplus.common.utils.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CacheThread implements Runnable{
    private String key;
    private Logger logger = LoggerFactory.getLogger(CacheThread.class);
    public CacheThread(String key) {
        this.key = key;
    }

    @Override
    public  void run() {
        if (StringUtils.isNotEmpty(key)){
            CacheUtils.remove(key);
            logger.info("删除缓存key:{}",key);
        }
    }
}
