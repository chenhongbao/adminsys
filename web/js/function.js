/**
 * Create a automatic dropdown list when user is typing.
 * @param list data be to displayed in the list
 * @param tag  tag under which the list is appended
 */
function createDropDownList(list, tag) {
    /* Get the position of the generated drop down list. */
    var rect = tag.getBoundingClientRect();
    var left = rect.left;
    var top = rect.bottom;


}

var CheckCode = 0.0;
/**
 * Generate the check code equation.
 * @param x <span /> tag
 */
function generateCheckCode(x) {
    if (!x) {
        return;
    }

    var a = Math.random().toFixed(1);
    var b = Math.random().toFixed(1);
    CheckCode = parseFloat(a) + parseFloat(b);

    var text = a + "+" + b + "=";
    x.innerHTML = text;
}

/**
 * Check the code for validity.
 * @param x <input /> tag
 * @return {boolean} true for success
 */
function checkCode(x) {
    if (!x) {
        return false;
    }
    if (parseFloat(x.value) == CheckCode.toFixed(1)) {
        return true;
    } else {
        return false;
    }
}


/**
 * Check all input fields has been filled.
 */

function checkInputField() {
    var valid = true;
    var list = document.getElementsByTagName("input");
    for (var i = 0; i < list.length; i = i + 1) {
        if (list.item(i).type.toLocaleUpperCase() != "TEXT"
            && list.item(i).type.toLocaleUpperCase() != "PASSWORD") {
            continue;
        }

        var n = list.item(i).getAttribute("name") + "Label";
        var e = document.getElementById(n);
        if (!e) {
            continue;
        }

        if (list.item(i).value != null
            && list.item(i).value.length < 1) {

            if (!e.style) {
                e.setAttribute("style", "text-decoration:line-through;color:#dc143c;");
            } else {
                e.style.textDecoration = "line-through";
                e.style.color = "#dc143c";
            }

            valid = false;

        } else if (list.item(i).value != null
            && list.item(i).value.length > 0) {

            if (!e.style) {
                e.setAttribute("style", "text-decoration:none;color:#000000;");
            } else {
                e.style.textDecoration = "none";
                e.style.color = "#000000";
            }
        }
    }
    if (!valid) {
        alert("某些项目没有填写，请检查。");
        return false;
    }
    return true;
}



