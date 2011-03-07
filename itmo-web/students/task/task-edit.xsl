<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../common.xsl"/>

    <xsl:template name="additional-header">
        <link type="text/css" rel="stylesheet" href="task-edit.css"/>
    </xsl:template>

    <xsl:template match="page" mode="content">
        <xsl:choose>
            <xsl:when test="menu/data/no-auth or menu/data/user-info/uid != 1">
                <div class="error">Ой. А у Вас нету прав.</div>
            </xsl:when>
            <xsl:when test="data/task">
                <xsl:choose>
                    <xsl:when test="data/task/@id">
                        <h2>Редактирование задачи (id=
                            <xsl:value-of select="data/task/@id"/>)
                        </h2>
                    </xsl:when>
                    <xsl:otherwise>
                        <h2>Создание задачи</h2>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:apply-templates select="data/task" mode="form"/>
            </xsl:when>
            <xsl:otherwise>
                <div class="error">Ой. Нет такого задания. Возможно, введено что-то не то.</div>
            </xsl:otherwise>
        </xsl:choose>


        <div class="empty">&#160;</div>
    </xsl:template>

    <xsl:template match="task" mode="form">
        <form action="save-task.xml" method="post">
            <xsl:if test="@id">
                <input type="hidden" name="task" value="{@id}"/>
            </xsl:if>
            <div>
                <div class="label">Модуль </div>
                <select name="module-id" class="right">
                    <xsl:variable name="task-module" select="module-id"/>
                    <xsl:for-each select="/page/data/modules/module">
                        <option value="{@id}">
                            <xsl:choose>
                                <xsl:when test="$task-module and @id = $task-module">
                                    <xsl:attribute name="selected">1</xsl:attribute>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:value-of select="."/>
                        </option>
                    </xsl:for-each>
                </select>
            </div>
            <div>
                <div class="label">Заголовок </div>
                <input type="text" name="name" class="text" value="{name}"/>
            </div>
            <div>
                <div class="label">Номер в модуле </div>
                <input type="text" name="module-npp" class="text" value="{module-npp}"/>
            </div>
            <div>
                <div class="label">Дома </div>
                <input type="checkbox" name="homework" class="text" value="1">
                    <xsl:if test="@homework and @homework = 1">
                        <xsl:attribute name="checked">1</xsl:attribute>
                    </xsl:if>
                </input>
            </div>
            <div>
                <div class="label">Скрывать </div>
                <input type="checkbox" name="hidden" class="checkbox" value="1">
                    <xsl:if test="@hidden and @hidden = 1">
                        <xsl:attribute name="checked">1</xsl:attribute>
                    </xsl:if>
                </input>
            </div>
            <div>
                <textarea name="body">
                    <xsl:value-of select="body"/>
                </textarea>
            </div>
            <div>
                <input type="submit" value="Сохранить"/>
            </div>
        </form>
    </xsl:template>

</xsl:stylesheet>