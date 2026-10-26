package br.com.alura.orgs.ui.activity

import android.app.Activity
import android.os.Bundle
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import br.com.alura.orgs.R
import br.com.alura.orgs.model.Produto
import br.com.alura.orgs.ui.recyclerview.adapter.ListaProdutosAdapter
import java.math.BigDecimal

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val recyclerView = findViewById<RecyclerView>(R.id.lista_produtos)

        recyclerView.addItemDecoration(
            DividerItemDecoration(this, LinearLayoutManager.VERTICAL)
        )

        recyclerView.adapter = ListaProdutosAdapter(
            this, listOf(
                Produto(
                    nome = "Poke dos cara",
                    descricao = "Poke da amizade",
                    valor = 40.00.toBigDecimal()
                ), Produto(
                    nome = "Aquela pizza",
                    descricao = "Maior fatia de pizza da cidade",
                    valor = 25.69.toBigDecimal()
                )
            )
        )
    }
}