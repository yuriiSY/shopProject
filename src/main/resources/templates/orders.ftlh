<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"/>
</head>
<body>
<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <a href="/">
            <span class="navbar-brand mb-0 h1">SHOP</span>
        </a>
        <div class=" d-flex flex-wrap">
            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button class="btn btn-light my-2 my-sm-0" type="submit" value="Exit"
                        onclick="window.location.href = '/logout'">
                    Log out
                </button>
            </form>
        </div>
    </div>
</nav>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Order number</th>
            <th scope="col">Date of Created</th>
            <th scope="col">Products</th>
            <th scope="col">Total Price</th>
            <th scope="col">Cancel</th>
            <th scope="col">Status</th>
        </tr>
        </thead>
        <#list orders as order>
        <tbody>
        <tr>
            <th scope="row">${order.id}</th>
            <th>${order.dateOfCreated}</th>
            <th><#list order.products as product>${product.title}<br>price:${product.price}<br></#list></th>
            <th>${order.totalPrice}</th>
            <th><a href="/orders-info/${user.id}/delete/${order.id}">cancel</a></th>
            <#if user.isAdmin()>
                <th>
                    <form action="/orders-info/admin/${user.id}/update-status/${order.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="update">
                    </form>
                </th>
            </#if>
            <th><#if order.status>Done <#else>Wait...</#if></th>
        </tr>
        </#list>
      </tbody>
    </table>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</body>
</html>