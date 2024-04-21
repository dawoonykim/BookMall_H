package com.bookMall.common.log;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LoggingAdvice {
	private static final Logger log = LoggerFactory.getLogger(LoggingAdvice.class);

	// target �޼����� �Ķ���͵� ������ ����մϴ�.
	@Before("execution(* com.bookMall.*.service.*.*(..)) || "
			+ "execution(* com.bookMall.*.dao.*.*(..))")
	public void startLog(JoinPoint jp) {

		log.info("before logging advice");
		log.info("-------------------------------------");
		log.info("-------------------------------------");

		// ���޵Ǵ� ��� �Ķ���͵��� Object�� �迭�� �����ɴϴ�.
		log.info("1:" + Arrays.toString(jp.getArgs()));

		//�ش� Advice�� Ÿ���� �˾Ƴ��ϴ�.
		log.info("2:" + jp.getKind());

		// �����ϴ� ��� ��ü�� �޼ҵ忡 ���� ������ �˾Ƴ� �� ����մϴ�.
		log.info("3:" + jp.getSignature().getName());

		// target ��ü�� �˾Ƴ� �� ����մϴ�.
		log.info("4:" + jp.getTarget().toString());

		// Advice�� ���ϴ� ��ü�� �˾Ƴ� �� ����մϴ�.
		log.info("5:" + jp.getThis().toString());



	}

	@After("execution(* com.bookMall.*.service.*.*(..)) || "
			+ "execution(* com.bookMall.*.*.dao.*.*(..))")
	public void after(JoinPoint jp) {
		log.info("-------------------------------------");
		log.info("-------------------------------------");

		// ���޵Ǵ� ��� �Ķ���͵��� Object�� �迭�� �����ɴϴ�.
		log.info("1:" + Arrays.toString(jp.getArgs()));

		// �ش� Advice�� Ÿ���� �˾Ƴ��ϴ�.
		log.info("2:" + jp.getKind());

		// �����ϴ� ��� ��ü�� �޼ҵ忡 ���� ������ �˾Ƴ� �� ����մϴ�.
		log.info("3:" + jp.getSignature().getName());

		// target ��ü�� �˾Ƴ� �� ����մϴ�.
		log.info("4:" + jp.getTarget().toString());

		// Advice�� ���ϴ� ��ü�� �˾Ƴ� �� ����մϴ�
		log.info("5:" + jp.getThis().toString());


		log.info("after logging advice");
	}


	// target �޼ҵ��� ���� �ð��� �����մϴ�.
	@Around("execution(* com.bookMall.*.service.*.*(..)) || "
			+ "execution(* com.bookMall.*.dao.*.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		long startTime = System.currentTimeMillis();
		log.info(Arrays.toString(pjp.getArgs()));

		// ���� Ÿ���� �����ϴ� �κ��̴�. �� �κ��� ������ advice�� ����� �޼ҵ尡 ���������ʽ��ϴ�.
		Object result = pjp.proceed(); // proceed�� Exception ���� ���� Throwable�� ó���ؾ� �մϴ�.

		long endTime = System.currentTimeMillis();
		// target �޼ҵ��� ���� �ð��� ����Ѵ�.
		log.info(pjp.getSignature().getName() + " : " + (endTime - startTime)+"ms");
		log.info("==============================");

		// Around�� ����� ��� �ݵ�� Object�� �����ؾ� �մϴ�.
		return result;
	}

}
