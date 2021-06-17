package com.alonso.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
//import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class DemoAspect {

//	@Before(value = "execution(* com.alonso.service.EmployeeService.*(..)) and args(name,empId)")
//	public void beforeAdvice(JoinPoint joinPoint, String name, String empId) {
//		System.out.println("\n\nBefore method:" + joinPoint.getSignature());
//
//		System.out.println("Creating Employee with name - " + name + " and id - " + empId);
//	}
//
//	@After(value = "execution(* com.alonso.service.EmployeeService.*(..)) and args(name,empId)")
//	public void afterAdvice(JoinPoint joinPoint, String name, String empId) {
//		System.out.println("After method:" + joinPoint.getSignature());
//
//		System.out.println("Successfully created Employee with name - " + name + " and id - " + empId);
//	}
	
//	@Around(value = "execution(* com.alonso.service.EmployeeService.*(..)) and args(name,empId)")
//	public void aroundAdvice(JoinPoint joinPoint, String name, String empId) {
//		System.out.println("Around method:" + joinPoint.getSignature());
//
//		System.out.println("Before/after created Employee with name - " + name + " and id - " + empId);
//	}
}
