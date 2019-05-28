package com.spring.common.log;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import com.spring.client.board.vo.BoardVO;

import lombok.extern.log4j.Log4j;

@Log4j //스프링 빈으로 인식하기위해 사용
@Component //해당 클래스의 Aspect를 구현한 것으로 나타내기 위해 사용
public class LoggerAdvice {
   
   //excutive(@excutive)메서드를 기준으로 Pointcut을 설정
   /*@Before("execution(* com.spring..*Impl.*(..))")
   public void printLogging() {
      log.info("------------------------------");
      log.info("[공통로그 Log] 비지니스 로직 수행 전 동작");
      log.info("------------------------------");
   }*/
   
   /*@Before("execution(* com.spring..*Impl.*(..)) && args(bvo)")
   public void printLogging(BoardVO bvo) {
      log.info("------------------------------");
      log.info("[공통로그 Log] 비지니스 로직 수행 전 동작");
      log.info("------------------------------");
      log.info("BoardVO 타입의 bvo 파라미터 값 : " + bvo);
   }*/
   
   
   /*@Before("execution(* com.spring..*Impl.*(..))")
   public void printLogging(JoinPoint jp) {
      log.info("--------------------------------------------");
      log.info("[공통로그 Log] 비지니스 로직 수행 전 동작");
      //getArgs(): 전달되는 모든 파라미터들을 Object의 배열로 가져옴
      //getSignature(): 실행하는 대상 객체의 대한 정보를 알아낼 때 사용
      log.info("[호출 메서드명]" + jp.getSignature().getName());
      log.info("[호출 메서드의 파라미터 값]" + Arrays.toString(jp.getArgs()));
      log.info("--------------------------------------------");
   }
   
   @AfterThrowing(pointcut="execution(* com.spring..*Impl.*(..)", throwing="exception")
   public void exceptionLogging(JoinPoint jp, Throwable exception) {
      log.info("------------------------------------------");
      log.info("[예외발생]");
      log.info("[예외발생 메서드명]" + jp.getSignature().getName());
      log.info("[예외 메세지] " + exception);
      log.info("------------------------------------------");
   }*/
   
   //비지니스 로직 메서드가 정상적으로 수행 된 후 동작
   /*@AfterThrowing(pointcut="execution(* com.spring..service.*Impl.*(..))")
   public void exceptionLogging(JoinPoint jp, Throwable exception) {
      log.info("------------------------------------------");
      log.info("[공통로그 Log] 비지니스 로직 수행 전 동작");
      log.info("afterReturningMethod() called......" + jp.getSignature().getName());
      log.info("------------------------------------------");
   }*/
   
   @Around("execution(* com.spring..*Impl.*(..))")
   public Object timeLogging(ProceedingJoinPoint pjp) throws Throwable {
         log.info("-----------------------");
         log.info("[공통 로그 Log] 비즈니스 로직 수행 전 동작");

   
   //long startTime = System.currentTimeMills();
   StopWatch watch = new StopWatch();
   watch.start();
   log.info(Arrays.toString(pjp.getArgs()));
   
   Object result = null;
   //proceed() : 실제 target 객체의 메서드를 실행하는 기능
   result = pjp.proceed();
   
   //long endTime = System.currentTimeMills();
   watch.stop();
   
    log.info("Class: " + pjp.getTarget().getClass());
     //logger.info(pjp.getSignature().getName() + " : 소요시간 " + (endTime-StartTime) + "ms");
     log.info(pjp.getSignature().getName() + " : 소요시간 " + watch.getTotalTimeSeconds() + "ms");
     
     log.info("[공통 로그 Log] 비즈니스 로직 수행 후 동작");
     log.info("-------------------------------");
     
     return result;
  }

}