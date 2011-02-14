package ru.obolshakova.students.itmo.task;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.test.AbstractDependencyInjectionSpringContextTests;

import java.util.Arrays;

/**
 * Author: Olga Bolshakova (obolshakova@yandex-team.ru)
 * Date: 11.02.11 0:30
 */
public class DbTaskServiceTest extends AbstractDependencyInjectionSpringContextTests {

    public DbTaskServiceTest() {
        super();
        setAutowireMode(AUTOWIRE_BY_NAME);
    }

    @Override
    protected String[] getConfigLocations() {
        return new String[]{
                "classpath:test-db-task-service.xml"
        };
    }

    private DbTaskService taskService;

    @Required
    public void setTaskService(final DbTaskService taskService) {
        this.taskService = taskService;
    }

    public void testExists() {
        assertNotNull(taskService);
    }

    public void testCreateTask() throws Exception {
        taskService.addTask(
                new Task(TaskType.SIMPLE, 4, 1, "Первая задача", "<div>В .zip архиве необходимо прислать:</div>\n" +
                        "        <ul>\n" +
                        "            <li>файл Anagram.java с исходным кодом</li>\n" +
                        "        </ul>\n" +
                        "\n" +
                        "        <div class=\"task\">\n" +
                        "            Необходимо реализовать две функции:\n" +
                        "            <ol>\n" +
                        "                <li>\n" +
                        "                    concatDepthFirst, выполняющую\n" +
                        "                    обход дерева в глубину и склеивающую значения\n" +
                        "                    элементов в порядке обхода.\n" +
                        "                </li>\n" +
                        "                <li>\n" +
                        "                    generateAnagram, принимающую на вход слово и\n" +
                        "                    выдающую в качестве результата другое слово,\n" +
                        "                    обладающее свойством: если буквы этого\n" +
                        "                    слова записать в вершинах дерева, то вызов\n" +
                        "                    функции concatDepthFirst на этом дереве выдаст\n" +
                        "                    исходное слово.\n" +
                        "                </li>\n" +
                        "            </ol>\n" +
                        "        </div>\n" +
                        "        <div>Присланный файл должен содержать следующий код:</div>\n" +
                        "        <pre>\n" +
                        "public class Anagram {\n" +
                        "\n" +
                        "    public static String concatDepthFirst(final String[] tree) {\n" +
                        "        //Ваша реализация\n" +
                        "    }\n" +
                        "\n" +
                        "    public static String generateAnagram(final String word) {\n" +
                        "        //Ваша реализация\n" +
                        "    }\n" +
                        "\n" +
                        "    //возможны другие функции\n" +
                        "}\n" +
                        "        </pre>\n" +
                        "        <div>\n" +
                        "            Где вместо комментария \"Ваша реализация\" должна находиться реализация метода.\n" +
                        "        </div>", false, false),
                Arrays.asList(
                        new TaskPoint("сдано вовремя", 1, 10),
                        new TaskPoint("сдано вообще", 1, 11)
                ),
                Arrays.asList(
                        new TaskKarma(1),
                        new TaskKarma(2),
                        new TaskKarma(3),
                        //new TaskKarma(5),
                        new TaskKarma(7),
                        new TaskKarma(9)
                )
        );
    }

    public void testGetTask() throws Exception {
        assertNotNull(taskService.getTask(2L));

        assertEquals(2, taskService.getTaskPoints(2L).size());
    }
}
