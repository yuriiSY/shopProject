INSERT INTO public.users(
    id, active, date_of_created, email, name, password, phone_number, image_id, cart_id)
    VALUES (1, true, '2020-03-21T12:31:48', 'admin@gmail.com','admin','$2a$08$M7sJAfFvOVA3z/2Zq2PV1O60.xqskiIuoGPjQXuA3odXYnjrXA2kC',
            '380661111111', null, null);
INSERT INTO public.user_role(user_id, roles)
VALUES (1, 'ROLE_ADMIN');