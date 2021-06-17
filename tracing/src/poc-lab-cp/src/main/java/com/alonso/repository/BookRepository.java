package com.alonso.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.alonso.model.Book;

@Repository
public interface BookRepository extends MongoRepository<Book, String> {
}
