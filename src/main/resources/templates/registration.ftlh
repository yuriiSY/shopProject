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
</head>
<body>
<section class="vh-100 bg-image"
         style="background: gray">
    <div class="mask d-flex align-items-center h-100 gradient-custom-3">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card" style="border-radius: 15px;">
                        <div class="card-body p-5">
                            <h2 class="text-uppercase text-center mb-5">Create an account</h2>
                            <form action="/registration" method="post" >
                                <div class="form-outline mb-4">
                                    <input type="text" id="form3Example1cg"  <#if nameError??>value="${user.name}"</#if> class="form-control form-control-lg ${(nameError??)?string('is-invalid', '')}" name="name" />
                                    <label class="form-label" for="form3Example1cg">Your Name</label>
                                    <#if nameError??>
                                        <div class="invalid-feedback">
                                            ${nameError}
                                        </div>
                                    </#if>
                                </div>
                                <div class="form-outline mb-4">
                                    <input type="email" id="form3Example3cg" <#if emailError??>value="${user.email}"</#if> class="form-control form-control-lg ${(emailError??)?string('is-invalid', '')}" name="email" />
                                    <label class="form-label" for="form3Example3cg">Your Email</label>
                                    <#if emailError??>
                                        <div class="invalid-feedback">
                                            ${emailError}
                                        </div>
                                    </#if>
                                </div>
                                <div class="form-outline mb-4">
                                    <input type="text" id="form3Example1cg" <#if phoneNumberError??>value="${user.email}"</#if> class="form-control form-control-lg ${(phoneNumberError??)?string('is-invalid', '')}" name="phoneNumber" />
                                    <label class="form-label" for="form3Example1cg">Phone number</label>
                                    <#if phoneNumberError??>
                                        <div class="invalid-feedback">
                                            ${phoneNumberError}
                                        </div>
                                    </#if>
                                </div>
                                <div class="form-outline mb-4">
                                    <input type="password" id="form3Example4cg" <#if passwordError??>value="${user.password}"</#if> class="form-control form-control-lg ${(passwordError??)?string('is-invalid', '')}" name="password"/>
                                    <label class="form-label" for="form3Example4cg">Password</label>
                                    <#if passwordError??>
                                        <div class="invalid-feedback">
                                            ${passwordError}
                                        </div>
                                    </#if>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <button class="btn btn-success btn-block btn-lg gradient-custom-4 text-body" type="submit">Register</button>
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                </div>

                                <#if errorMessage??>
                                    <div class="alert alert-danger" role="alert">
                                        ${errorMessage}
                                    </div>
                                </#if>

                                <p class="text-center text-muted mt-5 mb-0">Have already an account? <a href="/login"
                                                                      class="fw-bold text-body"><u>Login here</u></a></p>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>