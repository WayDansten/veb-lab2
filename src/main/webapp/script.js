const Y_ALLOWED_CHARACTERS_REGEXP = /[0-9.\-]+/;
const Y_FIELD = document.getElementById("Y");

const form = document.getElementById("dataform");
form.addEventListener('submit', submitForm);

const diagram = document.getElementById("diagram");
const image = diagram.getBoundingClientRect();
const x_center = image.left + image.width * 0.5;
const y_center = image.top + image.height * 0.5;

const result_table = document.getElementById("result_table");

Y_FIELD.addEventListener("keypress", event => {
    if (!Y_ALLOWED_CHARACTERS_REGEXP.test(event.key)) {
        event.preventDefault();
    }
});

Y_FIELD.addEventListener("paste", event => {
    if (!Y_ALLOWED_CHARACTERS_REGEXP.test(event.clipboardData.getData('text'))) {
        event.preventDefault();
    }
});

function checkboxToRadio(chbox)
{
    if(document.getElementById(chbox.id).checked === true) {
        document.getElementById('R1').checked = false;
        document.getElementById('R2').checked = false;
        document.getElementById('R3').checked = false;
        document.getElementById('R4').checked = false;
        document.getElementById('R5').checked = false;
        document.getElementById(chbox.id).checked = true;
    }
}

async function sendForm(x_result, y_result, r_result) {
    if (x_result === "" || y_result === "" || r_result === undefined) {
        alert("Все поля должны быть заполнены! Пожалуйста, повторите ввод.");
    } else {
        let params = new URLSearchParams();
        params.append("X", x_result);
        params.append("Y", y_result);
        params.append("R", r_result);
        let response = await fetch(`controller-servlet?${params.toString()}`, {
            method: "POST",
        });
        if (response.status === 400) {
            document.getElementById("Y").value="";
            alert("Координаты точки не попадают в ОДЗ! Пожалуйста, повторите ввод.");
        } else if (response.status === 200) {
            window.location.href = response.url;
        }
    }
}

async function submitForm(event) {

    event.preventDefault();

    let x_result = document.getElementById("X").options[document.getElementById("X").selectedIndex].text;
    let y_result = document.getElementById("Y").value;
    let r_result = $('#R').children('input:checkbox:checked').val();

    await sendForm(x_result, y_result, r_result)

}

diagram.addEventListener('click', async ({clientX, clientY}) => {
    let r_result = $('#R').children('input:checkbox:checked').val();
    if (r_result === undefined) {
        alert("Самый умный? Сначала введи радиус, а потом уже тыкай.");
    } else {
        let x_click = clientX;
        let y_click = clientY;
        let x_result = (x_click - x_center) * r_result / (image.width * 0.25);
        let y_result = - (y_click - y_center) * r_result / (image.height * 0.25);
        await sendForm(x_result, y_result, r_result);
    }
})

function mark_points() {
    let rows = result_table.rows;
    let r_result = parseFloat(rows[rows.length - 1].cells[3].innerHTML);
    for (let i = 1; i < result_table.rows.length; i++) {
        let cells = rows[i].cells;
        let x_result = parseFloat(cells[1].innerHTML);
        let y_result = parseFloat(cells[2].innerHTML);
        let x_coord = (200 + (x_result * (0.25 * image.width / r_result)));
        let y_coord = (200 - (y_result * (0.25 * image.height / r_result)));
        let point = document.createElementNS("http://www.w3.org/2000/svg", "circle")
        point.setAttribute("cx", `${x_coord}`);
        point.setAttribute("cy", `${y_coord}`);
        point.setAttribute("r", "2");
        point.setAttribute("stroke", "red");
        point.setAttribute("strokeWidth", "2px");
        diagram.appendChild(point);
    }
}

function check_previous_r() {
    let r = parseInt(result_table.rows[result_table.rows.length - 1].cells[3].innerHTML);
    for (let i = 1; i <= 5; i++) {
        let chbox = document.getElementById(`R${i}`);
        if (parseInt(chbox.value) === r) {
            chbox.checked = true
            break;
        }
    }
}

function onload_function() {
    mark_points();
    check_previous_r()
}

window.onload = onload_function();