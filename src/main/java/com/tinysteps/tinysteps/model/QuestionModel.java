package com.tinysteps.tinysteps.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "questions")
@Getter
@Setter
@NoArgsConstructor
public class QuestionModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "question_en", nullable = false)
    private String questionEnglish;

    @Column(name = "question_mal", columnDefinition = "TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")
    private String questionMalayalam;

    @Column(nullable = false, columnDefinition = "INT DEFAULT 0")
    private Integer severity;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private CategoryModel category;

    @ManyToOne
    @JoinColumn(name = "agegroup_id", nullable = false)
    private AgeGroupModel ageGroup;
}
