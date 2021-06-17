package com.alonso.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Book")
public class Book {
	@Id
	private String id;
	private String bookName;
	private String authorName;
	
	public String getID() {
		return id;
	}
	public String getBookName() {
		return bookName;
	}
	public String getAuthorName() {
		return authorName;
	}
	
	
}

