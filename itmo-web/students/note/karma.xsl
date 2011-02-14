<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="../notes.css"/>
        <link type="text/css" rel="stylesheet" href="../list.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <h2>Про карму</h2>
        <div class="intro">
            Карма - оценка студента в аспекте его желания учиться.
            Переводится в конце каждого модуля в оценку от 0 до 3 баллов
            в графу "Посещение лекций" за личностные качества студента.
            "Избыток" кармы может быть потрачен на восстановление утраченных
            в прошлом баллов (т.е. каждый студент практически в любой момент
            времени может одуматься, и возможность получить в итоге "отлично"
            у него остаётся).
        </div>
        <xsl:apply-templates select="data/karma-items" mode="table"/>

        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="karma-items" mode="table">
        <table>
            <tr>
                <th>сколько</th>
                <th>за что</th>
            </tr>

            <xsl:apply-templates select="item" mode="tr"/>

            <!--<tr>-->
                <!--<td class="green">+3</td>-->
                <!--<td>прислал задание первым</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+2</td>-->
                <!--<td>прислал задание вторым</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>прислал задание третьим</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>контрольная работа с первого раза выполнена на максимум</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+2</td>-->
                <!--<td>работа у доски</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+2</td>-->
                <!--<td>задание прислано до общего обсуждения</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>домашнее задание прислано вовремя</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>исправление незначительных замечаний в оценённом на максимум задании</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>присутствие на занятии (без опоздания)</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="green">+1</td>-->
                <!--<td>найдена ошибка или несоответствие в задании</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-3</td>-->
                <!--<td>дал списать товарищу</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-1</td>-->
                <!--<td>за каждую неделю просрочки выполнения задания</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-1</td>-->
                <!--<td>за каждую неудачную попытку сдать домашенее задание, начиная с 4-ой</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-1</td>-->
                <!--<td>за отсутствие на занятии по неизвестной преподавателю (а, значит, неуважительной) причине</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-1</td>-->
                <!--<td>студент на занятии был, но не выполнил задание, которое было необходимо выполнить</td>-->
            <!--</tr>-->
            <!--<tr>-->
                <!--<td class="red">-1</td>-->
                <!--<td>плохое поведение на занятии</td>-->
            <!--</tr>-->
        </table>
    </xsl:template>

    <xsl:template match="item" mode="tr">
        <tr>
            <td class="red">
                <xsl:if test="point-cnt &gt; 0">
                    <xsl:attribute name="class">green</xsl:attribute>
                    <xsl:text>+</xsl:text>
                </xsl:if>
                <xsl:value-of select="point-cnt"/>
            </td>
            <td>
                <xsl:value-of select="description"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>