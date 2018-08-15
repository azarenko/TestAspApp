// Note: Disabling and enabling to make bootstrap field validation work

window.onload = function () {

    var showRecovery = document.getElementsByClassName("show-recovery");
     if (showRecovery != null && showRecovery.length != 0) {
         showRecovery[0].onclick = function () {
             document.getElementById("login").style.display = "none";
             document.getElementById("passwordRecovery").style.display = "block";
             var userNameForgotNode = document.getElementById("UserNameForgot");
             if (userNameForgotNode != null) {
                 userNameForgotNode.disabled = false;
                 userNameForgotNode.focus();
             }
             document.getElementById("UserName").disabled = true;
             document.getElementById("Password").disabled = true;
         };
     }
     
     var hideRecovery = document.getElementsByClassName("hide-recovery");
     if (hideRecovery != null && hideRecovery.length != 0) {
         hideRecovery[0].onclick = function () {
             document.getElementById("passwordRecovery").style.display = "none";
             document.getElementById("login").style.display = "block";
             var userNameForgotNode = document.getElementById("UserNameForgot");
             if (userNameForgotNode != null) {
                 userNameForgotNode.disabled = true;
             }
             document.getElementById("UserName").disabled = false;
             document.getElementById("Password").disabled = false;
             document.getElementById("UserName").focus();
         };
     }

    document.querySelector("#login input[type='submit']").onclick = function () {
        if (document.getElementById("UserName").value === "" || document.getElementById("Password").value === "") {
            document.getElementById("credentialsError").style.display = "flex";
            var loginFailedMessageNode = document.getElementById("loginFailedMessage");
            if (loginFailedMessageNode != null) {
                loginFailedMessageNode.style.display = "none";
            }
            return false;
        } else {
            document.getElementById("credentialsError").style.display = "none";
        }
    };

    var licenseLinkNode = document.getElementById("licenseOptionsLink");

    if (licenseLinkNode != null) {
        licenseLinkNode.onclick = function () {
            document.getElementById("login").style.display = "none";
            document.getElementById("licenseOptions").style.display = "block";
        };
    }

    var licenseBackNode = document.getElementById("licenseOptionsBack");

    if (licenseBackNode != null) {
        licenseBackNode.onclick = function () {
            document.getElementById("licenseOptions").style.display = "none";
            document.getElementById("login").style.display = "block";
        };
    }
}