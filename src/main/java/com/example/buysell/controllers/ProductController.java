package com.example.buysell.controllers;

import com.example.buysell.models.Product;

import com.example.buysell.services.ProductServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.security.Principal;
import java.util.Map;

@Controller
public class ProductController {
    private final ProductServiceImpl productService;

    @Autowired
    public ProductController(ProductServiceImpl productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String products(@RequestParam(name = "title", required = false) String title,
                           Principal principal,
                           Model model,
                           @PageableDefault(sort ={"id"},direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Product> products = productService.listProducts(title,pageable);
        model.addAttribute("products", products);
        model.addAttribute("URL","/" );
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "products";
    }
    @GetMapping("/price-asc")
    public String productsSortByPriceAsc(@RequestParam(name = "title", required = false) String title,
                           Principal principal,
                           Model model,
                           @PageableDefault(sort ={"price"},direction = Sort.Direction.ASC) Pageable pageable) {

        Page<Product> products = productService.listProducts(title,pageable);
        model.addAttribute("products", products);
        model.addAttribute("URL","/" );
        model.addAttribute("user", productService.getUserByPrincipal(principal));

        return "products";
    }
    @GetMapping("/price-desc")
    public String productsSortByPriceDesc(@RequestParam(name = "title", required = false) String title,
                                         Principal principal,
                                         Model model,
                                         @PageableDefault(sort ={"price"},direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Product> products = productService.listProducts(title,pageable);
        model.addAttribute("products", products);
        model.addAttribute("URL","/" );
        model.addAttribute("user", productService.getUserByPrincipal(principal));

        return "products";
    }



    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model,Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "product-info";
    }



    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3,  @Valid Product product, BindingResult bindingResult,Model model, Principal principal,@PageableDefault(sort ={"id"},direction = Sort.Direction.DESC) Pageable pageable) throws IOException {

        Map<String,String> errorsMap = ControllersUtils.getErrors(bindingResult);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        Page<Product> products = productService.listProducts("",pageable);
        model.addAttribute("products", products);
        model.addAttribute("URL","/" );
        if (product.getTitle().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "products";
        }
        if (product.getDescription().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "products";
        }
        if (product.getCity().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "products";
        }

        model.addAttribute("product", product);
        productService.saveOrUpdateProduct(principal, product, file1, file2, file3);
        return "redirect:/";
    }

    @GetMapping("/product/{id}/cart")
    public String addProductToCart(@PathVariable Long id, Principal principal) {
        if(principal==null) {
            return "redirect:/";
        }
        productService.addToUserCart(id,principal);
        return "redirect:/";
    }

    @PostMapping("/product/{id}/delete")
    public String deleteProductByAdmin(@PathVariable Long id, Principal principal) {
        if (principal == null) {
            return "redirect:/";
        }
        productService.delProductById(id);
        return "redirect:/";
    }

    @RequestMapping(path = {"/search"})
    public String search(Model model, String title, @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable,  Principal principal) {
        if (title == null) {
            model.addAttribute("productsSearch", productService.listProducts(title,pageable));
        } else {
            model.addAttribute("productsSearch", productService.findByTitleSearch(title,pageable));
        }
        model.addAttribute("title", title);
        model.addAttribute("URL","/search" );
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "search";
    }

    @GetMapping("/product/{id}/update")
    public String productUpdate(@PathVariable Long id, Model model,Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("photoMain",product.getPreviewImageId());
        return "edit";
    }
    @Transactional
    @PostMapping("/product/update/edit")
    public String updateProduct(@RequestParam("productId") Long productId,@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2, @RequestParam("file3") MultipartFile file3, Product product, Principal principal) throws IOException {
        Product existProduct = productService.getProductById(productId);
        productService.update(existProduct,product,file1,file2,file3);
        return "redirect:/";
    }
}
