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
    <thead class="table-dark">
    <tr>
        <th>Username</th>
        <th>Email</th>
        <th>Phone number</th>
        <th>Active</th>
        <th>Role</th>
        <th>Ban</th>
        <th>Edit</th>
        <th>More</th>
        <th>Orders</th>
    </tr>
    </thead>
    <tbody>
    <#list users as user>
        <tr>
            <th>${user.name}</th>
            <th>${user.email}</th>
            <th>${user.phoneNumber}</th>
            <th><#if user.active>true<#else>false</#if></th>
            <th><#list user.roles as role>${role}</#list></th>
            <th>
                <form action="/admin/user/ban/${user.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <input type="submit" value="Ban">
                </form>
            </th>
            <th><a href="/admin/user/edit/${user.id}">Edit</a></th>
            <th><a href="/user/${user.id}">About</a></th>
            <th><a href="/orders-info/${user.id}">Orders</a></th>

        </tr>
    <#else>
        <h3>No users</h3>
    </#list>
    </tbody>
    <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/admin-active'">
        Active Users
    </button>
    <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/admin'">
        All Users
    </button>
    <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/admin-baned'">
        Baned Users
    </button>
    <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/admin/sorted-a-z'">
        Sort A-Z
    </button>
    <button type="button" class="btn btn-outline-secondary" onclick="window.location.href = '/admin/sorted-z-a'">
        Sort Z-A
    </button>
</table>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
        crossorigin="anonymous"></script>
</body>
</html>