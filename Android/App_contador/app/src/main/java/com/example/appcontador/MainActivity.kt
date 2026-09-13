package com.example.appcontador

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.appcontador.databinding.ActivityMainBinding
import com.example.appcontador.databinding.LayoutCounterActionsBinding
import com.example.appcontador.databinding.LayoutCounterDisplayBinding

class MainActivity : AppCompatActivity() {

    private var contador = 0
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        binding = ActivityMainBinding.inflate(layoutInflater)
        // Includes com raiz <merge> não sobem para ActivityMainBinding —
        // bind() no root encontra as views injetadas no pai.
        val displayBinding = LayoutCounterDisplayBinding.bind(binding.root)
        val actionsBinding = LayoutCounterActionsBinding.bind(binding.root)

        setContentView(binding.root)

        ViewCompat.setOnApplyWindowInsetsListener(binding.main) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val textContador = displayBinding.contador
        val botaoIncrementar = actionsBinding.botaoIncrementar
        val botaoDecrementar = actionsBinding.botaoDecrementar

        botaoIncrementar.setOnClickListener {
            textContador.text = "${++contador}"
        }

        botaoDecrementar.setOnClickListener {
            textContador.text = "${--contador}"
        }
    }
}