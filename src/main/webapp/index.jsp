<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.lab2.ResultData" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test</title>
    <link href="style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Play:wght@400;700&display=swap" rel="stylesheet" />
</head>
<body>
<form method="POST" id="dataform">
    <table border="1" cellspacing="0" width="100%">
        <tr>
            <th colspan=5>
                <h1>Горошников Тимофей Иванович, группа P3111, Вариант 21104</h1>
            </th>
        </tr>
        <tr>
            <th colspan=3 width="60%" class="label">Введите данные:</th>
            <th width="20%" class="label">Диаграмма:</th>
            <th width="20%" class="label">Предыдущие результаты:</th>
        </tr>
        <tr>
            <td align="center" width="20%">
                <label for="X" class="label">Выберите координату по X (-5 <= X <= 3):</label>
                <select id="X" name="X">
                    <option value=""></option>
                    <option value="-5">-5</option>
                    <option value="-4">-4</option>
                    <option value="-3">-3</option>
                    <option value="-2">-2</option>
                    <option value="-1">-1</option>
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                </select>
            </td>
            <td width="20%" align="center">
                <label for="Y" class="label">Введите координату по Y (-5 <= Y <= 3):</label>
                <input type="text" name="Y" id="Y" />
            </td>
            <td align="center" width="20%">
                <label for="R" class="label">Выберите радиус R (0 <= R <= 5):</label>
                <fieldset id="R" name="R">
                    <input type="checkbox" id="R1" name = "R1" value="1" onclick="checkboxToRadio(this)"/>
                    <label for="R1">1</label>
                    <input type="checkbox" id="R2" name = "R2" value="2" onclick="checkboxToRadio(this)"/>
                    <label for="R2">2</label>
                    <input type="checkbox" id="R3" name = "R3" value="3" onclick="checkboxToRadio(this)"/>
                    <label for="R3">3</label>
                    <input type="checkbox" id="R4" name = "R4" value="4" onclick="checkboxToRadio(this)"/>
                    <label for="R4">4</label>
                    <input type="checkbox" id="R5" name = "R5" value="5" onclick="checkboxToRadio(this)"/>
                    <label for="R5">5</label>
                </fieldset>
            </td>
            <td width="20%">
                <%@include file="image.svg"%>>
            </td>
            <td width="20%">
                <table border="1" cellspacing="0" id="result_table">
                    <tr>
                        <th width="15%" class="label">Результат</th>
                        <th width="15%" class="label">X</th>
                        <th width="15%" class="label">Y</th>
                        <th width="15%" class="label">R</th>
                        <th width="15%" class="label">Время выполнения</th>
                        <th width="25%" class="label">Текущее время</th>
                    </tr>
                    <%
                        Object sessionData = application.getAttribute("sessionData");
                        if (sessionData instanceof ArrayList<?>) {
                            @SuppressWarnings("unchecked")
                            List<ResultData> contents = new java.util.ArrayList<>(((ArrayList<ResultData>) sessionData));
                            for (int i = 0; i < contents.size(); i = i + 2) {
                                ResultData dataEntry = contents.get(i);
                        %>
                    <tr>
                        <td><%=dataEntry.hit()%></td>
                        <td><%=dataEntry.x()%></td>
                        <td><%=dataEntry.y()%></td>
                        <td><%=dataEntry.r()%></td>
                        <td><%=dataEntry.execTime()%></td>
                        <td><%=dataEntry.currTime()%></td>
                    </tr>
                    <%}}%>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan=5>
                <p align="center">
                    <input type="submit" id="button">
                </p>
            </td>
        </tr>
    </table>
</form>
<script type="text/javascript" src="script.js"></script>
<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
</body>
</html>