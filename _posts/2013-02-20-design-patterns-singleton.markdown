---
layout: post
title: "[设计模式学习笔记]单例模式"
date: 2013-02-20 12:49
comments: true
tags: [IT,设计模式,Java]
---
最近在看秦小波的__《设计模式之禅》__，虽然这东西只看是没有用的，但是在实际使用之前学习23种模式的概念，还是很重要！

### 单例模式类图（这是饿汉式的）

![单例模式类图](http://cnhalo.qiniudn.com/designpatterns/singleton_class.jpg)

### 单例模式通用代码（饿汉式）

<!--more-->

```java
public class Singleton {
	private static final Singleton singleton = new Singleton();

	// 限制产生多个对象
	private Singleton() {
	}

	// 通过该方法获取实例对象
	public static Singleton getSingleton(){
		return singleton;
	}
	
	// 类中其他方法，尽量是static
	public static void doSomething(){
	}
}
```

### 单例模式通用代码（懒汉式）

```java
public class Singleton {

	private static Singleton singleton = null;

		public static synchronized Singleton getInstance(){
    	if(singleton==null){
        		singleton = new Singleton();
    	}
   		return singleton;
	}
}
```

### 两种模式的比较
饿汉式是线程安全的,在类创建的同时就已经创建好一个静态的对象供系统使用,以后不在改变。懒汉式如果在创建实例对象时不加上synchronized则会导致对对象的访问不是线程安全的，推荐使用第一种。

### 单例模式的优点
1.由于单例模式在内存中只有一个实例，减少了内存开支，特别是一个对象需要频繁地创建，销毁时，而且创建或销毁时性能又无法优化，单例模式的优势就是非常明显。

2.由于单例模式只生成一个实例，所以减少了系统的性能开销，当一个对象的产生需要比较多的资源时，如读取配置、产生其他依赖对象时，则可以通过在应用启动时直接产生一个单例对象，然后用永久驻留内存的方式来解决（在Java EE中采用单例模式时需要注意JVM垃圾回收机制）。

3.单例模式可以避免对资源的多重占用，例如一个写文件动作，由于只有一个实例存在内存中，避免对同一个资源文件的同时写操作。

4.单例模式可以在系统设置全局的访问点，优化和共享资源访问，例如可以设计一个单例类，负责所有数据表的映射处理。
### 单例模式的缺点
1.单例模式一般没有接口，扩展和困难，若要扩展，除了修改代码基本上没有第二种途径可以实现。单例模式为什么不能增加接口呢？因为接口对单例模式是没有任何意义的，它要求“自动实例化”,并且提供单一实例、接口或抽象类是不可能被实例化的。当然在特殊情况下，单例模式可以实现接口、被继承等，需要在系统开发中根据环境判断。

2.单例模式对测试是不利的。在并行开发环境中，如果单例模式没有完成，是不能进行测试的，没有接口也不能使用mock的方式虚拟一个对象。

3.单例模式与单一职责原则有冲突。一个类应该只实现一个逻辑，而不关心它是否是单例的，是不是要单例取决于环境，单例模式把“要单例”和业务逻辑融合在一个类中。