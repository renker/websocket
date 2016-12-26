package com.ct.websocket.utils;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.annotate.JsonSerialize.Inclusion;

import com.ct.websocket.entity.Message;

/**
 * JSON转换
 * @author meicunzhi
 *
 */
public class JsonUtil {
	private static ObjectMapper mapper = new ObjectMapper();
	static {
		mapper.getSerializationConfig().setSerializationInclusion(
				Inclusion.ALWAYS);
		mapper.configure(SerializationConfig.Feature.WRITE_DATES_AS_TIMESTAMPS,
				false);
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
	}
	
	/**
	 * 将对象转换为字符串
	 * @param obj 要转换的对象
	 * @return
	 */
	public static String toJson(Object obj) {
		try {
			return mapper.writeValueAsString(obj);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	/**
	 * 将JSON字符串转换为需要的对象
	 * @param value 要转换的字符串
	 * @param clazz 要转换的对象
	 * @return
	 */
	public static <T> T fromJson(String value, Class<T> clazz) {
		try {
			return mapper.readValue(value, clazz);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	
	public static void main(String[] args) {
		Message msg = new Message();
		msg.setSubject("消息");
		msg.setMessage("消息");
		System.out.println(JsonUtil.toJson(msg));
	}
}
