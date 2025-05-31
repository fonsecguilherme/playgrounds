package com.example.androidviews

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.androidviews.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private var contadorValue = 0
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)

        enableEdgeToEdge()
        setContentView(binding.root)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val contador = binding.activityMainCountValue
        val botaoSomar = binding.activityMainIncrementButton
        val botaoSubtrair = binding.activityMainDecrementButton

        botaoSomar.setOnClickListener {
            contador.text = "${++contadorValue}"
        }

        botaoSubtrair.setOnClickListener {
            contador.text = "${--contadorValue}"
        }
    }
}