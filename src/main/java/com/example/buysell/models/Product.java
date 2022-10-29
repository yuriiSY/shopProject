package com.example.buysell.models;

import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "products")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;
    @NotBlank(message = "Please fill the title")
    @Column(name = "title")
    private String title;
    @NotBlank(message = "Please fill the description")
    @Column(name = "description", columnDefinition = "text")
    private String description;
    @Column(name = "price")
    private int price;
    @NotBlank(message = "Please fill the city")
    @Column(name = "city")
    private String city;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,
    mappedBy = "product")
    private List<Image> images = new ArrayList<>();
    private Long previewImageId;
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;
    private LocalDateTime dateOfCreated;
    @PrePersist
    private void init() {
        dateOfCreated = LocalDateTime.now();
    }
    public void addImageToProduct(Image image) {
        image.setProduct(this);
        images.add(image);
    }
}
