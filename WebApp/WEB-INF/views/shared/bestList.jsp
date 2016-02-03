<%@ page language="java"  
	import="java.lang.reflect.Field" 
   	import="java.lang.reflect.Method"
   	import="java.util.List"
   	import="java.util.Calendar"
   	import="java.sql.Date"      	
%>
<%
//======================================================================
//
//      Copyright (C) 2016  http://www.qeko.com    
//      All rights reserved
//
//      filename :BestList.jsp
//      description :万能代码之list view
//      引用：   <%@include file="../shared/bestList.jsp" ％>	
//
//      created by qeko.com at  02/03/2016 8:41:28
//      https://github.com/qeko/BestList.git
//      可以任意复制，修改本文源码，那怕面目全非，也必须保留以上信息，
//		请发一份你的改进告诉我，微信:win9500，邮箱：kook@21cn.com
//		我需要向你学习
//
//======================================================================

	PageList lists = (PageList) request.getAttribute("contentModel");
	List list = lists.getItems();
	for (int j = 0; j < list.size(); j++) {
		out.println("<TR><TD>");
		Object object = list.get(j);
		Class<?> clazz = object.getClass();
		//out.println(ReflectionUtils.invokeMethod(object, "getName", null , null)) ;
		Class superClass = clazz.getSuperclass();// 父类
		Class super2Class = superClass.getSuperclass();// 爷类
		Class super3Class = super2Class.getSuperclass();// 太爷类
			
		Method[] super3Methods = super3Class.getDeclaredMethods();
		for (int i = 0; i < super3Methods.length; i++) {
			super3Methods[i].setAccessible(true);
			if (super3Methods[i].getName().startsWith("getId")) {
				Object o = super3Methods[i].invoke(object, null);
				out.println("<input type=\"checkbox\" class=\"checkboxes\" name=\"Id\" value="+o+"/>");
				out.println("</TD><TD>");
			}
		}

		Method[] superMethods = superClass.getDeclaredMethods();
		for (int i = 0; i < superMethods.length; i++) {
			superMethods[i].setAccessible(true);
			if (superMethods[i].getName().startsWith("get")) {
				Object o = superMethods[i].invoke(object, null);
				out.println(o + "</TD><TD>");
			}
		}

		Method[] super2Methods = super2Class.getDeclaredMethods();
		for (int i = 0; i < super2Methods.length; i++) {
			super2Methods[i].setAccessible(true);
			if (super2Methods[i].getName().startsWith("get")) {
				Object o = super2Methods[i].invoke(object, null);
				out.println(o + "</TD><TD>");
			}
		}

		Field[] field = clazz.getDeclaredFields();
		for (Field fs : field)
		//for (int i = 0; i < field.length; i++)
		{
			String type = fs.getGenericType().toString();
			String name = fs.getName();
			name = name.replaceFirst(name.substring(0, 1), name.substring(0, 1).toUpperCase());
			Method m = object.getClass().getMethod("get" + name);
			if (type.equals("class java.util.Calendar")) {
				Calendar o = (Calendar) m.invoke(object);
				out.println(o.getTime().toLocaleString());
				out.println("</TD><TD>");
			} else if (type.equals("class java.lang.String")) {
				if (name.indexOf("Password") < 0) {
					Object o = m.invoke(object);
					out.println(o);
					out.println("</TD><TD>");
				}
			} else if (type.equals("class java.lang.Integer")) {
				Object o = m.invoke(object);
				out.println(o);
				out.println("</TD><TD>");
			} else if (type.equals("class java.lang.Double")) {
				Object o = m.invoke(object);
				out.println(o);
				out.println("</TD><TD>");
			} else if (type.equals("class java.lang.Short")) {
				Object o = m.invoke(object);
				out.println(o);
				out.println("</TD><TD>");
			} else if (type.equals("class java.lang.Boolean")) {
				Object o = m.invoke(object);
				out.println(o);
				out.println("</TD><TD>");
			} else if (type.equals("class java.lang.Date")) {
				Date o = (Date) m.invoke(object);
				out.println(o.toLocaleString());
				out.println("</TD><TD>");
			}
		}
		out.println("</TD></TR>");
	}
%>	