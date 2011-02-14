<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template match="page" mode="content">
        <h2>Перед тем, как отправить домашнее задание (требования)</h2>
        <div class="intro">
            Указаные здесь требования не являются единственно
            верными для написания кода на java. Но практически всегда
            в любой команде разработки существует свой стиль, которого
            придерживаются все члены группы. Придя в команду нужно
            уметь подстроиться под этот общий стиль.
        </div>
        <div class="intro">
            Когда я прошу присылать в качестве домашнего задания код,
            отвечающий указанным требованиям, можно считать, что я прошу
            подстроиться под свой стиль.
        </div>
        <div class="intro">
            Указанные здесь требования являются производными от широко
            распространённого стандарта <a href="http://www.oracle.com/technetwork/java/codeconvtoc-136057.html">Code Conventions for the Java
            Programming Language</a>.
        </div>
        <h3>Обязательные требования</h3>
        <ol>
            <li>
                Переменные следует объявлять там, где они
                понадобились первый раз. Объявить переменную –
                значит дать ей имя и определить её тип.
            </li>
            <div class="why">
                Это позволяет, разбираясь в Вашем коде, не отвлекаться на те переменные, которые в данный момент времени не нужны.
            </div>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    int n, k;
    n = 10;
    n++;
    k = 3;
</pre>
                <strong>Верно:</strong>
<pre>
    int n = 10;
    n++;
    int k = 3;
</pre>
            </div>
            <li>
                Переменные и методы следует называть с маленькой буквы,
                слова в названии переменной или метода не должны иметь
                разделителей и должны состоять только из латинских букв и,
                при необходимости, цифр.
                Если название содержит несколько слов, то каждое следующее
                слово должно начинаться с большой буквы.
            </li>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    long StartTime = System.currentTimeMillis();
    int stone_cnt = 10;
</pre>
                <strong>Верно:</strong>
<pre>
    long startTime = System.currentTimeMillis();
    int stoneCnt = 10;
</pre>
            </div>
            <li>
                Классы следует называть с большой буквы, слова в
                названии не должны иметь разделителей и должны
                состоять только из латинских букв и, при
                необходимости, цифр. Если название содержит
                несколько слов, то каждое следующее слово должно
                начинаться с большой буквы.
            </li>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    public class prime_numbers {...}
</pre>
                <strong>Верно:</strong>
<pre>
    public class PrimeNumbers {...}
</pre>
            </div>
            <li>
                Каждая новая переменная должна объявляться в отдельной строке.
            </li>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    int x, y;
</pre>
                <strong>Верно:</strong>
<pre>
    int x;
    int y;
</pre>
            </div>
            <li>
                Открывающая фигурная скобка, выделяющая фрагмент кода,
                относящийся к блокам if, for, while, switch, case, а также
                фигурная скобка после имени класса, должна находиться
                на той же строке, где и начало блока.
            </li>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    for (int i = 0; i != 10; i++)
    {
        //...
    }
</pre>
                <strong>Верно:</strong>
<pre>
    for (int i = 0; i != 10; i++) {
        //...
    }
</pre>
            </div>
            <li>
                Любой код, исполняемый в блоках if, for, while, switch, case, должен
                оборачиваться в фигурные скобки (не должно быть сокращённых
                форм записей).
            </li>
            <div class="why">
                Сокращённая запись часто приводит к ошибкам, которые тяжело
                вычислить, т.к. если такой блок кода потребуется расширить,
                то наличие скобок уже становится обязательным, о чём не
                всегда вспоминает человек, дописавший код.
            </div>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    if (x == 0) k = 75;
</pre>
                <strong>Верно:</strong>
<pre>
    if (x == 0) {
        k = 75;
    }
</pre>
            </div>
            <li>
                В качестве отступа (табуляции) в присылаем коде следует использовать
                четыре пробела (о том как и где это настроить в IDEA, написано
                <a href="note0-1.html">тут</a>).
            </li>
            <li>Стоит ставить пробел в следующих случаях:</li>
            <ul>
                <li>После ключевого слова, за которым следуют фигурные скобки, и перед открывающей фигурной скобкой.</li>
                <div class="example">
                    <strong>Не верно:</strong>
<pre>
    while(true){
        //...
    }
</pre>
                    <strong>Верно:</strong>
<pre>
    while (true) {
        //...
    }
</pre>
                </div>
                <li>После каждой запятой в списке аргументов.</li>
                <div class="example">
                    <strong>Не верно:</strong>
<pre>
    public static boolean hasString (String[] arr,String example) {
        //...
    }
</pre>
                    <strong>Верно:</strong>
<pre>
    public static boolean hasString (String[] arr, String example) {
        //...
    }
</pre>
                </div>
                <li>Все бинарные операции следует отделять от их операндов.</li>
                <div class="example">
                    <strong>Не верно:</strong>
<pre>
    a+=c+d;
    a=(a+b)/(c*d);

    while (d++=s++) {
        n++;
    }
    printSize("size is "+foo+"\n");
</pre>
                    <strong>Верно:</strong>
<pre>
    a += c + d;
    a = (a + b) / (c * d);

    while (d++ = s++) {
        n++;
    }
    printSize("size is " + foo + "\n");
</pre>
                </div>
                <li>После точки с запятой внутри for.</li>
                <div class="example">
                    <strong>Не верно:</strong>
<pre>
    for (int i = 0;i != 10;i++) {
        //...
    }
</pre>
                    <strong>Верно:</strong>
<pre>
    for (int i = 0; i != 10; i++) {
        //...
    }
</pre>
                </div>
                <li>После приведения типов.</li>
                <div class="example">
                    <strong>Не верно:</strong>
<pre>
    int x = (int)d;
</pre>
                    <strong>Верно:</strong>
<pre>
    int x = (int) d;
</pre>
                </div>
            </ul>
            <li>
                Стоит пользоваться упрощёнными конструкциями:
            </li>
            <ul>
                <li>инкремент</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    b[j] = &lt;выражение&gt;;
    j++;
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    b[j++] = &lt;выражение&gt;;
</pre>
                </div>
                <li>лишняя переменная</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    A a = &lt;выражение&gt;;
    return a;
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    return &lt;выражение&gt;;
</pre>
                </div>
                <li>работа с boolean-выражениями</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    if (&lt;условие&gt; == false) { ... }
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    if (!&lt;условие&gt;) { ... }
</pre>
                </div>
                <li>лишняя else-ветка</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    if (&lt;условие&gt;) {
        return true;
    } else {
        return false;
    }
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    return &lt;условие&gt;;
</pre>
                </div>
                <li>лишнее использование условного оператора</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    if (&lt;условие&gt;) {
        return true;
    }
    return false;
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    return &lt;условие&gt;;
</pre>
                </div>
                <li>формирование переменной внутри условного оператора</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    A a;
    if (&lt;условие&gt;) {
        a = &lt;выражение1&gt;;
    } else {
        a = &lt;выражение2&gt;;
    }
    return a;
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    if (&lt;условие&gt;) {
        return &lt;выражение1&gt;;
    }
    return &lt;выражение2&gt;;
</pre>
                </div>
                <li>формирование переменной внутри условного оператора - 2</li>
                <div class="example">
                    <strong>Конструкция вида:</strong>
<pre>
    A a = &lt;выражение1&gt;;
    if (&lt;условие&gt;) {
        a = &lt;выражение2&gt;;
    }
    return a;
</pre>
                    <strong>Может быть упрощена до:</strong>
<pre>
    if (&lt;условие&gt;) {
        return &lt;выражение2&gt;;
    }
    return &lt;выражение1&gt;;
</pre>
                </div>
            </ul>
            <li>
                Все входные параметры метода должны быть помечены как final (т.е. не
                могут модифицироваться в теле функции).
            </li>
            <div class="why">
                Переопределение параметров может привести к
                непредсказуемым ошибкам. Например, в метод приходит параметр "param"
                и в первой же строчке метода он переопределяется (например, param = param * 2);
                к концу метода разработчик забывает о том, что переопределил параметр,
                и вновь использует параметр param, ожидая, что в нём находится
                исходное значение; получает ошибку.
            </div>
            <div class="example">
                <strong>Не верно:</strong>
<pre>
    public static void doSomething(String param) {
        //...
    }
</pre>
                <strong>Верно:</strong>
<pre>
    public static void doSomething(final String param) {
        //...
    }
</pre>
            </div>
        </ol>
        <h4>NB</h4>
        <ul>
            <li>
                Правильное форматирование, расстановку пробелов и другое можно получить
                в Idea, вызвав Code -> Reformat Code, либо нажав Ctrl + Alt + L.
            </li>
        </ul>
        <h3>Прочие рекомендации</h3>
        <ol>
            <li>
                Переменные и методы следует называть полными, информативными словами,
                а не безликими "a" или "b".
            </li>
            <li>
                Все переменные, которые могут быть помечены как final, стоит помечать как final.
            </li>
            <div class="why">
                Это защищает от возможных ошибок и позволяет легче и быстрее воспринимать код (т.к.
                переменная, помеченная как final, не может поменять своего значения в будущем).
            </div>
            <div class="example">
                    <strong>Не верно:</strong>
<pre>
    public static void doSomething(final String param) {
        String trimmed = param.trim();
        //...
    }
</pre>
                    <strong>Верно:</strong>
<pre>
    public static void doSomething(final String param) {
        final String trimmed = param.trim();
        //...
    }
</pre>
                </div>
        </ol>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

</xsl:stylesheet>