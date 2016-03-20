package com.cun.util;

public class StringUtil {

	/**
	 * @ParameterNames captcha,vcode[service,login]
	 * */
	public static boolean equalWithcode(String captcha,String vcode){
		if (captcha==null||vcode==null||captcha.length()!=vcode.length()) {
			return false;
		}else {
			int len = captcha.length();
			for (int i = 0; i <len; i++) {
				if (captcha.charAt(i)==vcode.charAt(i)) {
					continue;
				}
				if (vcode.charAt(i)>='a'&&vcode.charAt(i)<='z') {
					char tmp = (char) (vcode.charAt(i)-'a'+'A');
					
					if (captcha.charAt(i) == tmp) {
						continue;
					}
					return false;
				}
			}
			return true;
		}
	}
}
