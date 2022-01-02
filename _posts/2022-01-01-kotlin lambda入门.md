---
title: kotlin lambda入门
---

```kotlin
fun main() {
    val say: (String) -> Unit = { str -> println(str) }
    say("Hello world!")
}
```

## lambda学的好，代码写的少！

学习lambda是每个kotlin开发者的必经之路，它可以帮你做很多事情，用得好还能提升不少的开发效率。可以说，只要你写kotlin，就绝对会接触到它！接下去我就来整个lambda入门！   

### 可调用对象
首先，我们学习lambda之前得先知道什么叫**可调用对象**。正如开头的例子，我声明了一个名为`say`的**可调用对象**，（PS：在kotlin中，你可以把可调用对象当成Java反射出来的Method，它可以被`invoke()`执行，但是要注意，它们俩并不是同一个东西）。
当然，你也可以通过以下方式将一个函数弄成一个可调用对象：
```kotlin
fun foo(str: String) {
    println(str)
}

fun main() {
    // 通过双冒号获取函数的可调用对象
    val say = ::foo
    say("Hello world!")
    // 当然 kotlin是允许重载操作符的，所以kotlin重载了调用操作符() 它实际上等价于
    say.invoke("Hello world!")
}
```
**注意：可调用对象可以被当做参数传递，这也是我们使用lambda最频繁的方式。**

### lambda的声明方式
正常来说，lambda由`参数、箭头以及返回值类型`构成，     
如：`(T) -> R`    
`T`代表**参数类型**，它由括号包裹起来(可以不写参数名字)    
`R`代表**返回值类型**，它和参数由箭头`->`分隔开来    

但是，神奇的是，lambda是可以定义**接收者**的，相当于**扩展函数**，它可以指定谁可以调用这个lambda，标准库中也有很多地方用到了这种方式。
如我们经常使用的`buildString { }` `buildList { }` `apply { }` 等等，他们都定义了接收者。
同样，定义有接收者的lambda也十分方便，和扩展函数一样，只需要在lambda的参数前加上接收者的类型即可。     
如：`R.(T) -> Unit`   
`R`代表**接收者的类型**   
`T`代表**参数类型**   
`Unit`代表**无返回值**（lambda不能像函数那样不写返回值代表无返回值，必须显式声明。）   

### lambda的使用
当一个函数只有一个参数，而且这个参数是一个lambda时，你可以省掉小括号，直接使用`函数名 { }`的方式调用这个函数，举个栗子：
```kotlin
fun foo(action: () -> Unit) {
    action()
    println("Invoked action.")
}

fun main() {
    foo({ println("Hello world!") })
    // 可以去掉括号
    foo { println("Hello world!") }
}
```
当一个函数有多个参数，但是最后一个参数是lambda的时候，可以将lambda用大括号的方式跟在小括号后面，举个栗子：
```kotlin
fun foo(str: String, action: () -> Unit) {
    action()
    println(str)
}

fun main() {
    foo("Arg", { println("Hello world!") })
    // 可以将大括号放在外面，更美观一些
    foo("Arg") { println("Hello world!") }
}
```
不过以上的两种方式，忘了也没关系，IDE会提醒你的23333

接下去我们看看lambda接收者的使用，我们来实现一个标准库中的`buildString`吧！
```kotlin
fun myBuildStr(builderAction: StringBuilder.() -> Unit /* 它的接受对象是StringBuilder类型，换种说法：它是StringBuilder的扩展函数 */): String {
    val sb = StringBuilder()
    sb.builderAction()
    // 当然你也可以这样调用
    // builderAction(sb)
    return sb.toString()
}

fun main() {
    val str = myBuildStr { /* 注意，这里的参数是this 指的是StringBuilder的对象 而且它不能被重命名 */
        // 这和在一个类中调用成员函数或是类的扩展函数是一样的 
        // 可以隐式调用
        append("Hello, ")
        // 也可以显式地使用this调用
        this.append("World!")
    }
    println(str)
}
```

### 多参数lambda
其实和普通的lambda大同小异，使用方法如下：
```kotlin
fun one(action: (String) -> Unit) {
    action("OK")
}

fun two(action: (String, String) -> Unit) {
    action("True", "False")
}

fun three(action: (String, Double, Int) -> Unit) {
    action("1", 2.0, 3)
}

fun main() {
    one { /* 如果没有给lambda的参数命名且只有一个参数时 默认参数名是it 你也可以手动给它命名 */
        println(it)
    }

    two { _, str -> /* 如果你不想使用其中一个或多个参数，可以用 _ 代替它的名字 */
        println(str)
    }

    three { a: String, b: Double, c: Int -> /* 如果你觉得只给参数名不够直观，你还可以给参数加上类型 */
        println(a)
        println(b)
        println(c)
    }
}
```
### 结束
完美！到此为止，你已经学会了lambda的基础用法！快去你的项目里试试吧！
