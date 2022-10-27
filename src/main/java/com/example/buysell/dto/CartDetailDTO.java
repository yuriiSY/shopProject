package com.example.buysell.dto;

import com.example.buysell.models.Product;
import lombok.Data;
import lombok.RequiredArgsConstructor;
@Data
@RequiredArgsConstructor
public class CartDetailDTO {
    private String title;
    private Long productId;
    private int price;
    private int amount;
    private int sum;
    private Long preview;
    public CartDetailDTO(Product product) {
        this.title = product.getTitle();
        this.productId=product.getId();
        this.price = product.getPrice();
        this.amount = 1;
        this.sum = product.getPrice();
        this.preview = product.getPreviewImageId();
    }
}
