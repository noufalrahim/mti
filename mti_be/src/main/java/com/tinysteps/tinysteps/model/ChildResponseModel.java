package com.tinysteps.tinysteps.model;

import org.springframework.stereotype.Component;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "child_response")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Component
public class ChildResponseModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="question_id", referencedColumnName = "id", nullable=false)
    private QuestionModel question;

    @Column(nullable=false)
    private Boolean questionAnswered;

    @Column()
    private Boolean answeredYes;

    @ManyToOne
    @JoinColumn(name="child_id", referencedColumnName = "id", nullable = false)
    private ChildModel child;
}
