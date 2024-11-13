<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.lab2.ResultData" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Результат</title>
    <link href="style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Play:wght@400;700&display=swap" rel="stylesheet" />
</head>
<body>
<table border="1" cellspacing="0" width="50%" align="center">
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
            ResultData result = contents.get(contents.size() - 1);
    %>
    <tr>
        <td><%=result.hit()%></td>
        <td><%=Math.floor(result.x() * 1000) / 1000%></td>
        <td><%=Math.floor(result.y() * 1000) / 1000%></td>
        <td><%=result.r()%></td>
        <td><%=result.execTime()%></td>
        <td><%=result.currTime()%></td>
    </tr>
    <%}%>
    <tr>
        <td colspan="6">
            <a href=<%=request.getContextPath()%>>
                <p align="center">Вернуться на главную страницу</p>
            </a>
        </td>
    </tr>
</table>
</body>
</html>
