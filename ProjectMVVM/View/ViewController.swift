//
//  ViewController.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let pokeViewModel: PokeViewModel = PokeViewModel()
    
    var filterData: [Result] = []
    var urlToDetail: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await setUpData()
        }
        setUpView()
    }
    
    func setUpData() async {
        await pokeViewModel.getDataFromAPI()
        filterData = pokeViewModel.pokemons
        tableView.reloadData()
    }
    
    func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.backButtonTitle = ""
    }
    
}

// Vamos a crear un extension del ViewController el cual tenga los protocolos de la table
// MARK: Table
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Retorna el numero de celdas que tendra la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    // Setear los valores en la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        // La forma en la cual podemos saber la posicion actual de nuestra celda es con indexPath.row
        let pokemon = filterData[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        cell.imageView?.image = HelperImage.setImage(id: HelperString.getIdFromUrl(url: pokemon.url))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlToDetail = filterData[indexPath.row].url
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let pokeDetailView = segue.destination as! PokeDetailViewController
            pokeDetailView.url = urlToDetail!
        }
    }
}

// Extension para mi searchbar
// MARK: SearchBar
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // searchText: Es el texto que estamos escribiendo es decir es como un onChange cada vez
        // que escribimos esta funcion se ejecuta
        filterData = searchText.isEmpty
        ? pokeViewModel.pokemons
        : pokeViewModel.pokemons.filter({ (pokemon: Result) -> Bool in
            return pokemon.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
