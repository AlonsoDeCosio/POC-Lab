package com.alonso.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

//import com.alonso.model.Employee;
//import com.alonso.model.User;
//import com.alonso.service.MongoDBService;
import com.alonso.repository.BookRepository;
import com.alonso.model.Book;

@RestController
public class MongoController {
	
	@Autowired
	private BookRepository myBookRepository ;
	
	@RequestMapping(value = "/book", method = RequestMethod.GET)
	public List<Book> listAllData() {
		return myBookRepository.findAll();
	}
	
	@RequestMapping(value = "/book/{bookId}", method = RequestMethod.GET)
	public Optional<Book> getBookDetails(@PathVariable String bookId) {
		System.out.print("Estoy aqui");
		return myBookRepository.findById(bookId);
	}
	
	@RequestMapping(value = "/book/add", method = RequestMethod.POST)
	public Book addNewBook(@RequestBody Book book) {
		return myBookRepository.save(book);
	}

}
