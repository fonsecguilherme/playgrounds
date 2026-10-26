package br.com.alura.orgs.ui.activity

import android.app.Activity
import android.os.Bundle
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.RecyclerView
import br.com.alura.orgs.R
import br.com.alura.orgs.model.Produto
import br.com.alura.orgs.ui.recyclerview.adapter.ListaProdutosAdapter

class MainActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.lista_produtos)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val recyclerView = findViewById<RecyclerView>(R.id.lista_produtos)

//        recyclerView.addItemDecoration(
//            DividerItemDecoration(this, LinearLayoutManager.VERTICAL)
//        )

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