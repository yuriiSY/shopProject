package com.example.buysell.dto;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@RequiredArgsConstructor
public class CartDTO {
    private int amountProducts;
    private Double sum;
    private List<CartDetailDTO> cartDetails = new ArrayList<>();
    public void aggregate() {
        this.amountProducts = cartDetails.size();
        this.sum = cartDetails.stream()
                        .map(CartDetailDTO::getSum)
                        .mapToDouble(Integer::doubleValue)
                        .sum();
    }
}
