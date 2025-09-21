package com.example.androidviews

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.example.androidviews.databinding.ActivityMainBinding
import com.example.androidviews.databinding.FragmentFirstBinding

class FirstFragment : Fragment() {

    private var contadorValue = 0
    private lateinit var binding: FragmentFirstBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflar o layout com View Binding
        binding = FragmentFirstBinding.inflate(inflater, container, false)

        // Tela com botões do contador
        val contador = binding.activityMainCountValue
        val botaoSomar = binding.activityMainIncrementButton
        val botaoSubtrair = binding.activityMainDecrementButton

        botaoSomar.setOnClickListener {
            contador.text = "${++contadorValue}"
        }

        botaoSubtrair.setOnClickListener {
            contador.text = "${--contadorValue}"
        }

        return binding.root
    }
}
