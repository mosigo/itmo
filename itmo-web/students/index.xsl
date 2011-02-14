<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:import href="common.xsl"/>

    <xsl:template match="page" mode="content">
        <h1>Сайт для студентов ИТМО группы 1742</h1>
        <h2>Практика по информатике</h2>
        <div class="contacts">
            <div>Меня зовут Ольга Большакова.</div>
            <label>e-mail:</label><span>o.bolshakova@yandex.ru</span><br/>
            <label>телефон:</label><span>+7 (904) 609 8517</span><br/>
        </div>
        <!--<a href="http://olga-bolshakova.moikrug.ru/?from=userlink"><img style="width: 16px; height: 16px; border:0; vertical-align: middle; margin-right: 3px;" src="http://moikrug.ru/images/icon.gif" alt="Мой Круг - Ольга Большакова" title="Мой Круг - Ольга Большакова" /></a><a href="http://olga-bolshakova.moikrug.ru/?from=userlink" title="Мой Круг - Ольга Большакова"><span style="color: #C71717">О</span>льга Большакова</a>-->
        <!--<a href="http://olga-bolshakova.moikrug.ru/?from=card" style="border: none;"><img src="http://moikrug.ru/users/P321645018/card.png" style="border: none;" alt="Мой Круг — Ольга Большакова" title="Мой Круг — Ольга Большакова" /></a>-->
        <h3>Расписание занятий</h3>
        <table class="rasp">
            <tr>
                <td rowspan="3">Суббота</td>
                <td>12:40-14:00</td>
                <td>чётная</td>
                <td>ауд. 410</td>
                <td rowspan="2">Практикум на ЭВМ</td>
            </tr>
            <tr>
                <td>14:20-15:40</td>
                <td/>
                <td>ауд. 410</td>
            </tr>
            <tr>
                <td>15:50-17:10</td>
                <td/>
                <td>ауд. 414</td>
                <td>Языки программирования и методы трансляции</td>
            </tr>
        </table>
        <div>
            Практика по <a href="http://sites.google.com/site/kubenskiy/Home/vesna-2011-goda/languages">курсу "Языки программирования и методы трансляции" А.А. Кубенского</a>.
        </div>
        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="/students/index.css"/>
    </xsl:template>

</xsl:stylesheet>